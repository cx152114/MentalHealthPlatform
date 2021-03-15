package com.dlt.common.controller;

import cn.hutool.core.date.DateUtil;
import com.dlt.common.model.R;
import com.dlt.common.util.AppFileUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * @author dlt
 */
@Controller
@RequestMapping("/common/file")
public class FileController {


    /**
     * 文件上传
     */
    @RequestMapping(value = "/uploadFile")
    @ResponseBody
    public R uploadFile(@RequestParam(value="file",required=false) MultipartFile mf) {
        //1,得到文件名
        String oldName = mf.getOriginalFilename();
        //2,根据文件名生成新的文件名
        String newName=AppFileUtils.createNewFileName(oldName);
        //3,得到当前日期的字符串
        String dirName= DateUtil.format(new Date(), "yyyy-MM-dd");
        //4,构造文件夹
        File dirFile=new File(AppFileUtils.UPLOAD_PATH,dirName);
        //5,判断当前文件夹是否存在
        if(!dirFile.exists()) {
            dirFile.mkdirs();//创建文件夹
        }
        //6,构造文件对象
        File file=new File(dirFile, newName+"_temp");
        //7,把mf里面的图片信息写入file
        try {
            mf.transferTo(file);
        } catch (IllegalStateException | IOException e) {
            e.printStackTrace();
        }
        return R.ok().put("path",dirName+"/"+newName+"_temp");
    }


    /**
     * 图片下载
     */
    @RequestMapping(value = "/showImageByPath")
    public ResponseEntity<Object> showImageByPath(String path){
        return AppFileUtils.createResponseEntity(path);
    }
}
