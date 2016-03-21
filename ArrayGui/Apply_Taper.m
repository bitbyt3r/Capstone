function [ taper_applied ] = Apply_Taper( input_buffers ,taper_array)

    size_scan = size(input_buffers);
    taper_applied = zeros(size_scan);
    for i = 1:size_scan(2);
        taper_applied(:,i) = input_buffers(:,i).*taper_array(i);
    end
        

end

