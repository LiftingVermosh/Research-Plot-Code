function batch_export(fig_array, format, output_dir, varargin)
% BATCH_EXPORT 批量导出多个图形
%   BATCH_EXPORT(FIG_ARRAY, FORMAT, OUTPUT_DIR) 将图形数组导出到指定目录
%   可选参数：同export_vector和export_raster的参数，将传递给单个导出函数

    if ~exist(output_dir, 'dir')
        mkdir(output_dir);
    end
    
    for i = 1:numel(fig_array)
        fig = fig_array(i);
        % 生成文件名
        if isempty(fig.Name)
            filename = fullfile(output_dir, sprintf('Figure_%d', i));
        else
            filename = fullfile(output_dir, fig.Name);
        end
        
        if any(strcmpi(format, {'PDF','EPS','SVG'}))
            export_vector(fig, filename, format, varargin{:});
        elseif any(strcmpi(format, {'PNG','TIFF','JPEG'}))
            export_raster(fig, filename, format, varargin{:});
        else
            error('不支持的格式: %s', format);
        end
    end
end
