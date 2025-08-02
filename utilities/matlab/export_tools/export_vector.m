% utilities/matlab/export_tools/export_vector.m
function export_vector(fig, filename, format, varargin)
% 导出矢量图形 (PDF/EPS/SVG)
% 输入:
%   fig - 图形句柄
%   filename - 输出文件名（无扩展名）
%   format - 格式 ('pdf','eps','svg')
% 可选参数:
%   'FontMode' - 字体模式 ('fixed' 固定大小, 'scaled' 缩放)
%   'Transparent' - 透明背景 (true/false)
%   'CMYK' - 转换为CMYK色彩空间 (true/false)
%   'CropMargins' - 裁剪边距 [左,下,右,上] (mm)

p = inputParser;
addParameter(p, 'FontMode', 'fixed', @ischar);
addParameter(p, 'Transparent', false, @islogical);
addParameter(p, 'CMYK', false, @islogical);
addParameter(p, 'CropMargins', [0,0,0,0], @(x)isnumeric(x)&&numel(x)==4);
parse(p, varargin{:});

% 应用预设设置
set(fig, 'InvertHardcopy', 'off');
if p.Results.Transparent
    set(fig, 'Color', 'none');
end

% 设置导出格式
switch lower(format)
    case 'pdf'
        driver = '-dpdf';
    case 'eps'
        driver = '-depsc';
    case 'svg'
        driver = '-dsvg';
    otherwise
        error('不支持的矢量格式: %s', format);
end

% 边界裁剪
if any(p.Results.CropMargins > 0)
    set_crop_margins(fig, p.Results.CropMargins);
end

% 字体处理
embed_fonts(fig, p.Results.FontMode);

% 执行导出
print(fig, driver, '-r0', [filename '.' format]);

% % CMYK转换
% if p.Results.CMYK && ismember(lower(format), {'pdf','eps'})
%     convert_to_cmyk([filename '.' format]);
% end
end
