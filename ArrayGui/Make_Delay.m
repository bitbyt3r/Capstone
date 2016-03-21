function [ shifted_buffers] = Make_Delay( input_buffers, delay_mat, sample_rate )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

%0,0  0,1 ........ 1,0 1,1 etc.....
    input_counter = 0;
    delay = [];
    for jj = 1:(length(delay_mat));
        
        delay = [delay delay_mat(:,jj)];
    end
   
    max_shift_right = 0;
    max_shift_left = 0;
    data_size = size(input_buffers);
    input_size = data_size(2);
    
    for ii = 1:input_size;
        
        input_counter = input_counter + 1;
        
        buffer_shift = sample_rate * delay(ii);
        buffer_shift = round(buffer_shift);
        
        
        if(buffer_shift > 0);
           buffer_shift = abs(buffer_shift);
           max_shift_left = max(max_shift_left,buffer_shift);
           shifted_array = padarray(input_buffers(:,ii),[buffer_shift,0],'post');
           shifted_buffers{input_counter} = shifted_array;
        elseif(buffer_shift < 0);
           buffer_shift = abs(buffer_shift);
           max_shift_right = max(max_shift_right,buffer_shift);
           shifted_array = padarray(input_buffers(:,ii),[buffer_shift,0],'pre');
           shifted_buffers{input_counter} = shifted_array;
        elseif(buffer_shift == 0);
            shifted_buffers{input_counter} = input_buffers(:,ii);
        end;
    end;
    
    overall_size = input_size + max_shift_right + max_shift_left;
    input_counter = 0;
    
    for ii = 1:input_size;
      
        input_counter = input_counter + 1;
        
        buffer_shift = sample_rate * delay(ii);
        buffer_shift = round(buffer_shift);
       
        
        if(buffer_shift > 0);
           buffer_shift = abs(buffer_shift);
           x = overall_size - (input_size + buffer_shift + max_shift_right);
           additional_pad = overall_size - input_size - buffer_shift - x;
           shifted_buffers{ii} = padarray(shifted_buffers{ii},[additional_pad,0],'post');
           shifted_buffers{ii} = padarray(shifted_buffers{ii},[x,0],'pre');
           
        elseif(buffer_shift < 0);
           buffer_shift = abs(buffer_shift);
           y = overall_size - (input_size + buffer_shift + max_shift_left);
           additional_pad = overall_size - input_size - buffer_shift - y;
           shifted_buffers{ii} = padarray(shifted_buffers{ii},[additional_pad,0],'pre');
           shifted_buffers{ii} = padarray(shifted_buffers{ii},[y,0],'post');
           
        elseif(buffer_shift == 0);
           shifted_buffers{ii} = padarray(shifted_buffers{ii},[max_shift_left,0],'pre');
           shifted_buffers{ii} = padarray(shifted_buffers{ii},[max_shift_right,0],'post');
        end;
    end;

end
