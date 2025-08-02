% utilities/matlab/export_tools/export_raster.m
function export_raster(fig, filename, format, dpi, varargin)
% 导出位图 (PNG/TIFF)
% 输入:
%   fig - 图形句柄
%   filename - 输出文件名
%   format - 格式 ('png','tiff')
%   dpi - 分辨率 (整数)
% 可选参数:
%   'Compression' - TIFF压缩方式 ('none','lzw')
%   'Transparent' - 透明背景 (true/false)

p = inputParser;
addParameter(p, 'Compression', 'lzw', @ischar);
addParameter(p, 'Transparent', false, @islogical);
parse(p, varargin{:});

% 自动优化渲染设置
auto_adjust_dpi(fig, dpi);

% 设置背景
if p.Results.Transparent
    set(fig, 'Color', 'none');
else
    set(fig, 'Color', 'w');
end

% 选择格式
switch lower(format)
    case 'png'
        driver = '-dpng';
        options = sprintf('-r%d', dpi);
    case 'tiff'
        driver = '-dtiff';
        options = sprintf('-r%d -%s', dpi, p.Results.Compression);
    otherwise
        error('不支持的位图格式: %s', format);
end

% 执行导出
print(fig, driver, options, filename);
end
