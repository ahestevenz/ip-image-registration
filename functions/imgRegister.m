function [moving_reg, optimizer, metric, R_reg] = imgRegister(moving, fixed, growthfactor, epsilon, initialradius, iterations, samples, histogrambins, pixels, type)

%% Metric variables
[optimizer,metric] = imregconfig('multimodal');

% optimizer -> registration.optimizer.OnePlusOneEvolutionary
% 
% GrowthFactor: Growth factor of the search radius. It is a positive scalar value that the optimizer uses to control 
% the rate at which the search radius grows in parameter space. If you set GrowthFactor to a large value, the optimization is fast, 
% but it might result in finding only the metric's local extrema. If you set GrowthFactor to a small value, the optimization 
% is slower, but it is likely to converge on a better solution. The default value of GrowthFactor is 1.05.
% 
% Epsilon: Minimum size of the search radius. It is a positive scalar value that controls the accuracy of convergence by adjusting 
% the minimum size of the search radius. If you set Epsilon to a small value, the optimization of the metric is more accurate, 
% but the computation takes longer. If you set Epsilon to a large value, the computation time deceases at the expense of accuracy. 
% The default value of Epsilon is 1.5e-6.
% 
% InitialRadius: Initial size of search radius. It is a positive scalar value that controls the initial search radius of the optimizer. 
% If you set InitialRadius to a large value, the computation time decreases. However, overly large values of InitialRadius might result 
% in an optimization that fails to converge. The default value of InitialRadius is 6.25e-3.
% 
% MaximumIterations: Maximum number of optimizer iterations. It is a positive scalar integer value that determines the maximum number 
% of iterations the optimizer performs at any given pyramid level. The registration could converge before the optimizer reaches the maximum 
% number of iterations. The default value of MaximumIterations is 100.

% metric -> registration.metric.MattesMutualInformation() 
% 
% NumberOfSpatialSamples: is a positive scalar integer value that defines the number of random pixels imregister uses to 
% compute the metric. Your registration results are more reproducible (at the cost of performance) as you increase this 
% value. imregister only uses NumberOfSpatialSamples when UseAllPixels = 0 (false). The default value for 
% NumberOfSpatialSamples is 500.
% 
% NumberOfHistogramBins: Number of histogram bins used to compute the metric. NumberOfHistogramBins is a positive scalar
% integer value that defines the number of bins imregister uses to compute the joint distribution histogram. 
% The default value is 50, and the minimum value is 5.
% 
% UseAllPixels: Logical scalar that specifies whether imregister should use all pixels in the overlap region of the 
% images to compute the metric.You can achieve significantly better performance if you set this property to 0 (false). 
% When UseAllPixels = 0, the NumberOfSpatialSamples property controls the number of random pixel locations that imregister 
% uses to compute the metric. The results of your registration might not be reproducible when UseAllPixels = 0. This is
% because imregister selects a random subset of pixels from the images to compute the metric. 
% The default value for UseAllPixels is 1 (true).
%
% Link: http://www.mathworks.com/help/images/examples/registering-multimodal-3-d-medical-images.html

if (growthfactor>0); optimizer.GrowthFactor=growthfactor; end
if (epsilon>0); optimizer.Epsilon=epsilon; end
if (initialradius>0); optimizer.InitialRadius=initialradius; end
if (iterations>0); optimizer.MaximumIterations=iterations; end
if (samples>0); metric.NumberOfSpatialSamples=samples; end
if (histogrambins>0); metric.NumberOfHistogramBins=histogrambins; end
if (pixels>=0); metric.UseAllPixels=pixels; end

%% Registration

% Transform TypeDescription
% 
% 'translation'(x,y) translation.
% 'rigid' Rigid transformation consisting of translation and rotation.
% 'similarity' Nonreflective similarity transformation consisting of translation, rotation, and scale. 
% 'affine' Affine transformation consisting of translation, rotation, scale, and shear.
%
% The 'similarity' and 'affine' transformation types always involve nonreflective transformations.

[moving_reg, R_reg]=imregister(moving, fixed, type, optimizer, metric); 
    
end