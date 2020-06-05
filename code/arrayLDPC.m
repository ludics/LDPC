function H = arrayLDPC(p, j, k)
A = circshift(eye(p),[0, 1]);
H = zeros(p * j, p * k);
for ia=1:j
	for ib=1:k
		H((ia-1)*p+1:ia*p,(ib-1)*p+1:ib*p) = A ^ ((ia-1) * (ib-1));
	end
end

		

