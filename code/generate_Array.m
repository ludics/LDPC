function H = generate_Array(p, j, k)
A = circshift(eye(p), 1);
% A = gf(A, 1);
H = zeros(p * j, p * k);
% H = gf(H, 1);
iH = zeros(j, k);
for ia=1:j
	for ib=1:k
                t = mod(ib + ia - 2, k) + 1;
		if ia > t
			iH(ia, mod(ib + ia - 2, k)+ 1) = -1;
		else
			iH(ia, mod(ib + ia - 2, k)+ 1) = ((ia-1) * (ib-1));
		end
	end
end
for ia=1:j
	for ib=1:k
		if iH(ia, ib) == -1
			H((ia-1)*p+1:ia*p,(ib-1)*p+1:ib*p) = 0;
		else
			H((ia-1)*p+1:ia*p,(ib-1)*p+1:ib*p) = A ^ iH(ia, ib);
		end
		% iH(ia, ib) = ((ia-1) * (ib-1));
	end
end
H = H(:, end:-1:1);
end
