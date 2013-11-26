function G = gaussian ( sigma )
M = ceil(3*sigma);
x = -M:M;
G = (1/(sigma*sqrt(2*pi))*exp(-x.^2/(2*sigma.^2)));
G_sigma = G / sum(sum(G));
end

