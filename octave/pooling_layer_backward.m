% #############################################################################################
% #########  YOU SHOULD MAINTAIN THE RETURN TYPE AND SHAPE AS PROVIDED IN STARTER CODE   ######
% #############################################################################################

function [input_od] = pooling_layer_backward(output, input, layer)
% Pooling backward

% Args:
% output: a cell array contains output data and shape information
% input: a cell array contains input data and shape information
% layer: one cnn layer, defined in testLeNet.m

% Returns:
% input_od: gradients w.r.t input data

h_in = input.height;
w_in = input.width;
c = input.channel;
batch_size = input.batch_size;
input_od = zeros(size(input.data));
stride = layer.stride;
data = reshape(input.data(:,:),h_in,w_in,c,batch_size);
outputtemp = zeros(h_in,w_in,c,batch_size);
k = layer.k;

indexrow = 1:stride:input.height;
indexcol = 1:stride:input.width;
h_out = output.height;
w_out = output.width;
input1 = input;
% for k = 1 : batch_size
% input1.data = input.data(:,k);
% col(:,:,k) = im2col_conv(input1, layer, h_out, w_out);
% 
% end
outputdifftemp = reshape(output.diff,h_out,w_out,c,batch_size);

for i =1 :size(indexcol,2)
for  j =1 : size(indexrow,2)



 temp =  (data(indexrow(j):indexrow(j)+k-1,indexcol(i):indexcol(i)+k-1,:,:));
 temp1 = reshape(temp,k*k,size(temp,3)*size(temp,4));
 
 gradtemp = zeros(size(temp1));
 [val,ind] = max (temp1,[], 1);
 indices1 = sub2ind(size(temp1), ind, 1:1:size(val,2));
 
 gradtemp(indices1) = outputdifftemp(j,i,:) ;
 gradtemp = reshape(gradtemp,k,k,size(temp,3),size(temp,4));
 
outputtemp(indexrow(j):indexrow(j)+k-1,indexcol(i):indexcol(i)+k-1,:,:) = gradtemp;
 
 
end

end

outputtemp = reshape(outputtemp,h_in*w_in*c,batch_size);
 input_od = outputtemp;


% TODO: your implementation goes below this comment
% implementation begins

% implementation ends

assert(all(size(input.data) == size(input_od)), 'input_od does not have the right length');

end
