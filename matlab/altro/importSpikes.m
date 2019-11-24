function data = importSpikes
% clear all

% data import
threshold = 75;
% path = "/Home/Documents/Unimib/Tesina/spikeFilter/matlab/data/";
% file_name = "raw_neuronal_activity";
fileName = "raw_bicuculline_activity";

rawData = ncread(fileName + ".va", '/stream_frame_0/data', [1,1,16000], [32,32,4000]);
data = permute(double(rawData),[2,1,3]);
clear rawData;
clear fileName

% row_n = size(unfilt_data, 1);
% col_n = size(unfilt_data, 2);
% limit = size(unfilt_data, 3);

%filter
% a = [-0.186616724285372, 0.389858030800281];
% b = [0.313059602323645, -0.626119204647290, 0.313059602323645];
% filt_data = zeros(row_n,col_n,limit);
% filt_data2 = zeros(row_n,col_n,limit);
% for t=1:limit
%     for row=1:row_n
%         for col=1:col_n
%             sum1 = unfilt_data(row,col,t) * b(1);
%             sum2 = 0;
%             if t > 1
%                 sum1 = sum1 + unfilt_data(row,col,t-1) * b(2);
%                 sum2 = filt_data(row,col,t-1) * a(1);
%             end
%             if t > 2
%                 sum1 = sum1 + unfilt_data(row,col,t-2) * b(3);
%                 sum2 = sum2 + filt_data(row,col,t-2) * a(2);
%             end
%             diff = sum1 - sum2;
%             filt_data(row,col,t) = diff;
%             filt_data2(row,col,t) = diff^2;
%         end
%     end
% end
% 
% variance(:,:) = var(filt_data, 0, 3);
% 
% imagesc(variance, [0, 100])
% colorbar

end