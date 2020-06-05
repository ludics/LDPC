function [Hf] = generate_Hf()
m = 5; % 2^m
p = 2;
q = 32; % q-ary field
prim_poly = [1 0 0 1 0 1];
field = gftuple([-1:p^m-2]', prim_poly, p);
% B-J码生成矩阵第1、2行
g1 = gf([1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 0], m);
g2 = gf([0 1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31], m);
% C存储B-J码中的所有码字
C = gf(zeros((q - 1) * (q + 1), q + 1), m);
for i=1:q+1
    % 循环移位得到B-J码不同划分
    g_temp = circshift(g1', i)';
    % 得到每个划分中的不同码字
    for j=1:q-1
        mul = j * ones(1, q + 1);
        C((i - 1) * (q - 1) + j, :) = C((i - 1) * (q - 1) + j, :) + mul .* g_temp;
    end
end
b = double(C.x);
% （q-1）元替换，q元域中的元素对应（q-1）长的向量
Loc = eye(31);
Loc = [zeros(1, 31); Loc];
% 选取前6个划分中的码字
Lamda = 6;
% 进行替换得到生成矩阵H
H = zeros((q - 1) * Lamda, (q - 1) * (q + 1));
for i=1:(q - 1) * Lamda
    for j=1:q+1
        H(i, (j - 1) * (q - 1) + 1:j * (q - 1)) = Loc(b(i, j) + 1, :);
    end
end
n = (q - 1) * (q + 1); % 列数
k = (q - 1) * Lamda; % 行数
% 进行列置换使得H的最后K列线性无关
j = 1;
i = 0;
ite = 0;
H2 = [];
while i < k && ite < n
    i = i + 1;
    H2 = [H2, H(:, j)];
    if rank(H2) == i
        H(:, j) = [];
        ite = ite + 1;
    else
        H2(:, i) = [];
        i = i - 1;
        j = j + 1;
        ite = ite + 1;
    end
end
% Hf为最后生成的校验矩阵
Hf = [H, H2];
end

