function rgb = hex2rgb(hexStr)
% HEX2RGB 将十六进制颜色代码转换为RGB值
%   输入:
%       hexStr - 十六进制颜色字符串，格式为'#RRGGBB'或'RRGGBB'
%                也支持3位简写格式'#RGB'
%                可以输入单个字符串或字符串数组
%   输出:
%       rgb    - RGB值矩阵，范围[0,1]，每行对应一个颜色
    
    % 验证输入
    if isempty(hexStr)
        rgb = [];
        return;
    end
    
    % 确保输入为字符串数组
    if ischar(hexStr)
        hexStr = string(hexStr);
    elseif iscell(hexStr)
        hexStr = string(hexStr);
    end
    
    % 初始化输出矩阵
    nColors = numel(hexStr);
    rgb = zeros(nColors, 3);
    
    for i = 1:nColors
        hex = char(hexStr(i));
        
        % 去除#号
        if hex(1) == '#'
            hex = hex(2:end);
        end
        
        % 处理3位简写格式
        if length(hex) == 3
            hex = [hex(1), hex(1), hex(2), hex(2), hex(3), hex(3)];
        end
        
        % 验证长度
        if length(hex) ~= 6
            error('十六进制颜色代码必须是3或6位字符');
        end
        
        % 转换为RGB
        r = hex2dec(hex(1:2)) / 255;
        g = hex2dec(hex(3:4)) / 255;
        b = hex2dec(hex(5:6)) / 255;
        
        rgb(i, :) = [r, g, b];
    end
end
