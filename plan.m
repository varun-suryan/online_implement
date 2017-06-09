l = 0.5;
epsilon = 5;
delta = 0.2;
max = 5;
noise = 0.5;

zeta = (2 * epsilon^2 * noise^2) / (max^2 * log(2/delta));
lambda = sqrt(-2 * l^2 * log(1 - zeta));

length_e = 4; width_e = 4;
subplot(2, 2, 1);
rectangle('Position',[0 0 length_e width_e]);
hold on;


spaceX_store = [];
spaceY_store = [];
t = linspace(0, 2 * pi);

for spaceX = sqrt(2) * lambda : 2 * lambda : length_e 
	for spaceY = sqrt(2) * lambda : 2 * lambda : width_e
		spaceX_store = [spaceX_store, spaceX];
		spaceY_store = [spaceY_store, spaceY];
		plot(spaceX + 2 * lambda * cos(t), spaceY + 2 * lambda * sin(t));
		hold on;
	end
end
axis equal;
scatter(spaceX_store, spaceY_store, 'b');

points = [spaceX_store; spaceY_store];
new = 99999;
i = 1;
while i < new
	index_c = [];
	for j = i + 1 : size(points, 2)
		if (points(1, i) - points(1, j))^2 + (points(2, i) - points(2, j))^2 <= 16 * lambda^2
			index_c = [index_c; j];
		end
	end
	for len = size(index_c, 1) : -1 : 1
		points(: , index_c(len, 1)) = [];
	end
	new = size(points, 2);
	i = i + 1;
end
subplot(2, 2, 2);
for i  = 1 : size(points, 2)
	plot(points(1, i) + 2 * lambda * cos(t), points(2, i) + 2 * lambda * sin(t));
	%plot(points(1, i) + 6 * lambda * cos(t), points(2, i) + 6 * lambda * sin(t));
	%rectangle('Position',[points(1, i)-6*lambda  points(2, i)-6*lambda 12*lambda 12*lambda]);
	%[XX, YY] = meshgrid(points(1, i) - 5.5*lambda : lambda/sqrt(2) : points(1, i) + 5.5*lambda, points(2, i) - 5.5*lambda : lambda/sqrt(2) : points(2, i) + 5.5*lambda);
	%all_X = [all_X ; XX(:)]; all_Y = [all_Y ; YY(:)];
	hold on;
end



subplot(2, 2, 3);
rectangle('Position',[0 0 length_e width_e]);
hold on;
all_X = [] ; all_Y = [];
for i  = 1 : size(points, 2)
%	plot(points(1, i) + 2 * lambda * cos(t), points(2, i) + 2 * lambda * sin(t));
	plot(points(1, i) + 6 * lambda * cos(t), points(2, i) + 6 * lambda * sin(t));
	%rectangle('Position',[points(1, i)-6*lambda  points(2, i)-6*lambda 12*lambda 12*lambda]);
	[XX, YY] = meshgrid(points(1, i) - 5.5*lambda : lambda/sqrt(2) : points(1, i) + 5.5*lambda, points(2, i) - 5.5*lambda : lambda/sqrt(2) : points(2, i) + 5.5*lambda);
	all_X = [all_X ; XX(:)]; all_Y = [all_Y ; YY(:)];
	hold on;
end

design_matrix = [];

size(all_X)
size(all_Y)

for i = 1 : length(all_X)
	for j = 1 : length(all_Y)
		if 0 < all_X(i) < 4 && 0 < all_Y(i) < 4
			collected_sample = normrnd(all_X(i)^2 + all_Y(i)^2 , 0.5);
			design_matrix = [design_matrix ; all_X(i) all_Y(j) collected_sample];
		end
	end
end



scatter (all_X, all_Y);

axis equal;