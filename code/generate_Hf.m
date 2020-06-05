function [Hf] = generate_Hf()
m = 5; % 2^m
p = 2;
q = 32; % q-ary field
prim_poly = [1 0 0 1 0 1];
field = gftuple([-1:p^m-2]', prim_poly, p);
% B-J�����ɾ����1��2��
g1 = gf([1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 0], m);
g2 = gf([0 1 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31], m);
% C�洢B-J���е���������
C = gf(zeros((q - 1) * (q + 1), q + 1), m);
for i=1:q+1
    % ѭ����λ�õ�B-J�벻ͬ����
    g_temp = circshift(g1', i)';
    % �õ�ÿ�������еĲ�ͬ����
    for j=1:q-1
        mul = j * ones(1, q + 1);
        C((i - 1) * (q - 1) + j, :) = C((i - 1) * (q - 1) + j, :) + mul .* g_temp;
    end
end
b = double(C.x);
% ��q-1��Ԫ�滻��qԪ���е�Ԫ�ض�Ӧ��q-1����������
Loc = eye(31);
Loc = [zeros(1, 31); Loc];
% ѡȡǰ6�������е�����
Lamda = 6;
% �����滻�õ����ɾ���H
H = zeros((q - 1) * Lamda, (q - 1) * (q + 1));
for i=1:(q - 1) * Lamda
    for j=1:q+1
        H(i, (j - 1) * (q - 1) + 1:j * (q - 1)) = Loc(b(i, j) + 1, :);
    end
end
n = (q - 1) * (q + 1); % ����
k = (q - 1) * Lamda; % ����
% �������û�ʹ��H�����K�������޹�
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
% HfΪ������ɵ�У�����
Hf = [H, H2];
end

