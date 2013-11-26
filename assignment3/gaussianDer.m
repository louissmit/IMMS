function Gd = gaussianDer (G, sigma )
M = ceil(3*sigma);
X = -M:M;
Gd = -X / (sigma.^2) .* G;
end

