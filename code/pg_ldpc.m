s = 5;
q = 2^s;

m = 2;
n = q^2 + q + 1;

M = "x^15 + x^14 + x^13 + x^12 + x^11 + x^5 + x^4 + x^3 + x^2 + x + 1";
%M = [1, 1,1,1,1,0, 0,0,0,0,1, 1,1,1,1,1]
GF = zeros(32768, 16);
B = zeros(33, 16);

alpha = [0, 1]; % alpha = "x"
%for i=1:2^((m+1)*s)
%    GF(i, 1:length(alpha)) = alpha;
%    [tmp, alpha] = gfdeconv(gfconv(alpha, "x"), M);
%end

[q,gamma] = gfdeconv("x^"+num2str(n), M);
beta = gamma;
for i=1:2^s   
    %B(i+1, 1:length(beta)) = beta;
    B(i+1, 1:length(beta)) = beta;
    [tmp, beta] = gfdeconv(gfconv(beta, gamma), M);
end

alpha = [0, 1];
beta = [1];
points = zeros(1025, 16);
for i=1:2^s
    for j=1:2^s
        combine = gfadd(gfconv(B(i, 1:16), alpha), gfconv(B(j, 1:16), beta));
        [tmp, r] = gfdeconv(combine, M);
        points((i-1)*(2^s)+j, 1:length(r)) = r;
    end
end

ans = points(2:1024, 1:16);




