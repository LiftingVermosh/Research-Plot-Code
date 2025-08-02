function hexStr = rgb2hex(rgb)
% RGB2HEX 将RGB值转换为十六进制颜色代码
%   输入:
%       rgb - RGB值矩阵(n×3)，范围[0,1]或[0,255]
%             如果值>1，则假定为[0,255]范围
%   输出:
%       hexStr - 十六进制颜色代码字符串数组，格式为'#RRGGBB'
    
    % 验证输入
    if size(rgb, 2) ~= 3
        error('输入必须是n×3的RGB矩阵');
    end
    
    % 检测范围并归一化
    if any(rgb(:) > 1)
        rgb = rgb / 255;
    end
    
    % 确保值在[0,1]范围内
    rgb = max(0, min(1, rgb));
    
    % 转换为0-255整数
    rgb255 = round(rgb * 255);
    
    % 转换为十六进制
    nColors = size(rgb255, 1);
    hexStr = strings(nColors, 1);
    
    for i = 1:nColors
        r = dec2hex(rgb255(i, 1), 2);
        g = dec2hex(rgb255(i, 2), 2);
        b = dec2hex(rgb255(i, 3), 2);
        
        hexStr(i) = ['#', r, g, b];
    end
end
