filename_hlop = "hlop.wav"
filename_another = "./data/drums.wav"
savepath = "./"

function[y] = convolve(f, g)
    y = f * g;
endfunction;

function[s_v] = shift(v)
    v_len = length(v)
    s_v = [v(v_len), v(1:v_len - 1)]
endfunction

function[matr] = produceShiftMatrix(x)
    x_len = length(x)
    matr = zeros(x_len, x_len)
    for i = 1:x_len
        matr(:,i) = [x]
        x = shift(x)
    end
endfunction

function[f, g] = pad(f, g)
    m = length(f) + length(g) - 1
    f = [f, zeros(1, m - length(f))]
    g = [g, zeros(1, m - length(g))]
endfunction


function[] = apply_conv(filename1, filename2)
    [x1, fs] =  wavread(filename1)
    [x2, fs] = wavread(filename2)
    [x, g] = pad(x1, x2)
    [matr] = produceShiftMatrix(x)
    y = mtlb_t(convolve(matr, mtlb_t(g)))
    disp(y)
endfunction
    
//[x,g] = pad(x,g)

    
//[matr] = produceShiftMatrix(x)


//y = mtlb_t(convolve(matr, mtlb_t(g)))
//res = conv(x, g)
//disp("Inside function")
//disp(res)
//disp("Our function")
//disp(y)
