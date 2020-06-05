clear;

siglen = 837;

H = generate_Hf();

A = sparse(H);
hEnc = comm.LDPCEncoder('ParityCheckMatrix', A);
hDec = comm.LDPCDecoder('ParityCheckMatrix', A);

hMod = comm.BPSKModulator;
hDemod = comm.BPSKDemodulator('DecisionMethod', 'Approximate log-likelihood ratio');

hChan = comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (SNR)');


hErrorCalc = comm.ErrorRate;
EbNomin = 3.5;
EbNomax = 4.5;
numerrmin = 10;
EbNovec = EbNomin:0.2:EbNomax;
numEbNos = length(EbNovec);

ber = zeros(1, numEbNos);
berVec = zeros(3, numEbNos);
intv = cell(1, numEbNos);

berVec = zeros(3, numEbNos);
block = zeros(1, numEbNos);
block_err = zeros(1, numEbNos);
block_err_rate = zeros(1, numEbNos);
for jj=1:numEbNos
    EbNo = EbNovec(jj);
    snr = EbNo;
    reset(hErrorCalc)
    hChan.SNR = snr;
    
    while (block_err(jj) < numerrmin)
        data = logical(randi([0 1], siglen, 1));
        encodedData = step(hEnc, data);
        modSignal = step(hMod, encodedData);
        receivedSignal = step(hChan, modSignal);
        demodSignal = step(hDemod, receivedSignal);
        receivedBits = step(hDec, demodSignal);
        berVec(:, jj) = step(hErrorCalc, data, receivedBits);
        if (~isequal(data, receivedBits))
            block_err(jj) = block_err(jj) + 1;
        end
        block(jj) = block(jj) + 1;
        berVec(2, jj);
    end
    
    [ber(jj), intv1] = berconfint(berVec(2, jj), berVec(3, jj) - 1, .98);
    block_err_rate(jj) = block_err(jj) / block(jj);
    intv{jj} = intv1;
    disp(['EbNo = ' num2str(EbNo) 'dB,' num2str(berVec(2, jj)) ...
        'errors, BER = ' num2str(ber(jj))])
end


figure(1)
fitEbNo = EbNomin:0.1:EbNomax;
berfit(EbNovec, ber, fitEbNo, [], 'exp');
figure(2)
fitEbNo = EbNomin:0.1:EbNomax;
berfit(EbNovec, block_err_rate, fitEbNo, [], 'exp');