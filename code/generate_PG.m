function [H, idx] = generate_PG(GF, points)
s = 5;
q = 2^s;

m = 2;
n = q^2 + q + 1;
k = n - (m+1)^s - 1;

GF = string(GF);
tmp = string(zeros(length(GF), 1));
for i=1:length(GF)
    tmp(i) = join(GF(i,:));
end
GF = tmp;

points = string(points);
tmp = string(zeros(length(points), 1));
for i=1:length(points)
    tmp(i) = join(points(i,:));
end
points = tmp;

idx = [];
for i=1:length(points)
    idx = [idx, mod(find(GF==points(i)),n)];
end

idx = unique(idx);

row = zeros(1, n);
H = zeros(n - k, n);

for i = 1:length(idx)
    row(idx(i)) = 1;
end

row2 = [row, row];

for i = 1:n-k
    H(i,:) = row2(i:i+n-1);
end

end

