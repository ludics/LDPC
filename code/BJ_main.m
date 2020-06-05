clear;


siglen = 837;
H = generate_BJ();
[bj_ber, bj_block_err_rate] = get_BER(H, siglen);

siglen = 813;
load('GF_points.mat');
H = generate_PG(GF, points);

[pg_ber, pg_block_err_rate] = get_BER(H, siglen);


p = 31; k = 33; j = 5;
siglen = 868;
H = generate_Array(p, j, k);
[ar_ber, ar_block_err_rate] = get_BER(H, siglen);

EbNomin = 3.5;
EbNomax = 4.5;
fitEbNo = EbNomin:0.1:EbNomax;
save('data.mat', 'bj_ber', 'bj_block_err_rate', 'pg_ber', 'pg_block_err_rate', 'ar_ber', 'ar_block_err_rate')

figure(1)
berfit(EbNovec, pg_ber, fitEbNo, [], 'exp');
figure(2)
berfit(EbNovec, pg_block_err_rate, fitEbNo, [], 'exp');