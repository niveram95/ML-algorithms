function Problem2b()
rng(1); % For reproducibility
r = sqrt(rand(100,1)); % Radius
t = 2*pi*rand(100,1); % Angle
data1 = [r.*cos(t), r.*sin(t)]; % Points
r2 = sqrt(3*rand(100,1)+2); % Radius
t2 = 2*pi*rand(100,1); % Angle
data2 = [r2.*cos(t2), r2.*sin(t2)]; % points
data3 = [data1;data2];
theclass = ones(200,1);
theclass(1:100) = -1;

res = fitcsvm(data3,theclass,'KernelFunction','polynomial','BoxConstraint',5,'PolynomialOrder',2);
% Predict scores over the grid
d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(data3(:,1)):d:max(data3(:,1)),...
    min(data3(:,2)):d:max(data3(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
[~,scores] = predict(res,xGrid);

% Plot the data and the decision boundary

hold on
contour(x1Grid,x2Grid,reshape(scores(:,2),size(x1Grid)),[0 0],'c','LineWidth',4);
axis equal
hold off
end
