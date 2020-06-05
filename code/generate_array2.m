function H = generate_array2(m, q)
H = zeros(m*q, q^2);
for j = 1:q
    H(1:q,(j-1)*q+1:j*q) = eye(q);
end
for i=2:m
    for j=1:q
        H((i-1)*q+1:i*q,(j-1)*q+1:j*q) = rcycl
    end

end
end