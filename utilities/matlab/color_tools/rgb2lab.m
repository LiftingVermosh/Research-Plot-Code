function lab = rgb2lab(rgb)
% RGB2LAB 将RGB转换为CIELAB颜色空间
%   使用D65标准光源
    
    % 转换为XYZ颜色空间
    xyz = rgb2xyz(rgb);
    
    % 参考白点(D65)
    ref_X = 0.95047;
    ref_Y = 1.00000;
    ref_Z = 1.08883;
    
    % 归一化
    x = xyz(:,1) / ref_X;
    y = xyz(:,2) / ref_Y;
    z = xyz(:,3) / ref_Z;
    
    % 非线性变换
    epsilon = 0.008856;
    kappa = 903.3;
    
    % f函数
    f = @(t) (t > epsilon.^3) .* t.^(1/3) + (t <= epsilon.^3) .* (kappa*t + 16)/116;
    
    fx = f(x);
    fy = f(y);
    fz = f(z);
    
    % 计算LAB值
    L = 116 * fy - 16;
    a = 500 * (fx - fy);
    b = 200 * (fy - fz);
    
    lab = [L, a, b];
end
