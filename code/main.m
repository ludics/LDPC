clear;

%%
% BJ-LDPC
EbNomin = 1.1;
EbNomax = 4.5;
EbNovec = EbNomin:0.2:EbNomax;
fitEbNo = EbNomin:0.1:EbNomax;

siglen = 837;
H = generate_BJ();
[bj_ber, bj_block_err_rate] = get_BER(H, siglen, EbNomin, EbNomax);
save('data_bj.mat', 'bj_ber', 'bj_block_err_rate');

figure(1)
berfit(EbNovec, bj_ber, fitEbNo, [], 'exp');
figure(2)
berfit(EbNovec, bj_block_err_rate-eps, fitEbNo, [], 'exp');

%%
% PG-LDPC
EbNomin = 1.1;
EbNomax = 3.9;
EbNovec = EbNomin:0.2:EbNomax;
fitEbNo = EbNomin:0.1:EbNomax;
siglen = 813;
% pg_ldpc.m;
load('GF_points.mat');
H = generate_PG(GF, points);
[pg_ber, pg_block_err_rate] = get_BER(H, siglen, EbNomin, EbNomax);
save('data_pg.mat', 'pg_ber', 'pg_block_err_rate');
figure(3)
berfit(EbNovec, pg_ber, fitEbNo, [], 'exp');
figure(4)
berfit(EbNovec, pg_block_err_rate-eps, fitEbNo, [], 'exp');

%%
% Array LDPC
EbNomin = 1.1;
EbNomax = 4.3;
EbNovec = EbNomin:0.2:EbNomax;
fitEbNo = EbNomin:0.1:EbNomax;

p = 31; k = 33; j = 5;
siglen = 868;
H = arrayLDPC(p, j, k);
[ar_ber, ar_block_err_rate] = get_BER(H, siglen, EbNomin, EbNomax);
save('data_ar.mat', 'ar_ber', 'ar_block_err_rate');
% 
figure(5)
berfit(EbNovec, ar_ber, fitEbNo, [], 'exp');
figure(6)
berfit(EbNovec, ar_block_err_rate-eps, fitEbNo, [], 'exp');
