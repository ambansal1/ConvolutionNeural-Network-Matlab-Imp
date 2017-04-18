% #############################################################################################
% #########  YOU SHOULD MAINTAIN THE RETURN TYPE AND SHAPE AS PROVIDED IN STARTER CODE   ######
% #############################################################################################

function [params, param_winc] = sgd_momentum(w_rate, b_rate, mu, weight_decay, params, param_winc, param_grad)
% update the parameters with sgd with momentum

%% function input
% w_rate (scalar): learning rate for w at current step
% b_rate (scalar): learning rate for b at current step
% mu (scalar): momentum
% weight_decay (scalar): weigth decay of w
% params (cell array): original weight parameters
% param_winc (cell array): buffer to store history gradient accumulation
% param_grad (cell array): gradient of parameter

%% function output
% params (cell array): updated parameters
% param_winc (cell array): updated buffer

% TODO: your implementation goes below this comment
% implementation begins


for j = 1:size(params,2)


    
param_winc{j}.w = mu.*param_winc{j}.w + (w_rate.*((param_grad{j}.w) + (weight_decay.*params{j}.w)));

param_winc{j}.b = mu.*param_winc{j}.b + (b_rate.*param_grad{j}.b);




params{j}.w = params{j}.w - param_winc{j}.w ;
params{j}.b = params{j}.b - param_winc{j}.b ;


end


% implementation ends

assert(all(size(params) == size(param_grad)), 'params_ does not have the right length');
assert(all(size(param_winc) == size(param_grad)), 'param_winc_ does not have the right length');

end
