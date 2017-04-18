% #############################################################################################
% #########  YOU SHOULD MAINTAIN THE RETURN TYPE AND SHAPE AS PROVIDED IN STARTER CODE   ######
% #############################################################################################

function [output] = pooling_layer_forward(input, layer)
% Pooling forward

% Args:
% input: a cell array contains output data and shape information
% layer: one cnn layer, defined in testLeNet.m

% Returns:
% output: a cell array contains output data and shape information

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
k = layer.k;
pad = layer.pad;
stride = layer.stride;

h_out = (h_in + 2*pad - k) / stride + 1;
w_out = (w_in + 2*pad - k) / stride + 1;

output.height = h_out;
output.width = w_out;
output.channel = c;
output.batch_size = batch_size;

output.data = zeros([h_out * w_out * c, batch_size]);
data = reshape(input.data(:,:),h_in,w_in,c,batch_size);

indexrow = 1:stride:input.height;
indexcol = 1:stride:input.width;


for  j =1 : size(indexrow,2)
for i =1 :size(indexcol,2)


 temp =  (data(indexrow(j):indexrow(j)+k-1,indexcol(i):indexcol(i)+k-1,:,:));
 value(j,i,:,:) = max(max(temp,[],1),[],2);
 
 
end

end
% C = max(data(indexrow:indexrow+k-1,indexcol:indexcol+k-1))
% 
% a = max(data(1:k:end,1:k:end,:,:),data(2:k:end,1:k:end,:,:));
% 	b = max(data(1:k:end,2:k:end,:,:),data(2:k:end,2:k:end,:,:));
%     
%      c = cat(5, data(1:k:end,1:k:end,:,:),data(2:k:end,1:k:end,:,:),data(1:k:end,2:k:end,:,:),data(2:k:end,2:k:end,:,:));
% [e,index]= (max(c,5));
% 
%     c(index) = 1;
% c(~index) = 0;
% 	out = max(a,b);
% TODO: your implementation goes below this comment
% implementation begins

% implementation ends
out = reshape(value,h_out * w_out * c, batch_size);
output.data = out;
assert(all(size(output.data) == [h_out * w_out * c, batch_size]), 'output.data does not have the right length');

end

