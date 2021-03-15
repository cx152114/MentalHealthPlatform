package com.dlt.business.controller;


import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.business.entity.ArticleType;
import com.dlt.business.service.IArticleTypeService;
import com.dlt.common.model.R;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author cx
 * @since 2021-02-14
 */
@Controller
@RequestMapping("/business/articleType")
public class ArticleTypeController {

    @Autowired
    private IArticleTypeService articleTypeService;


    @GetMapping
    @RequiresPermissions("business:articleType:search")
    public String articleTypeManagement() {
        return "business/articleType-list";
    }

    @PostMapping(value = "/findTargetArticleType")
    @RequiresPermissions("business:articleType:search")
    @ResponseBody
    public R findTargetArticleType(String typeName){
        QueryWrapper queryWrapper = new QueryWrapper();
        if (!StringUtils.isEmpty(typeName)) {
            queryWrapper.like("type_name", typeName);
        }
        List<ArticleType> articleTypeList=articleTypeService.list(queryWrapper);
        return R.ok().put("rows",articleTypeList);
    }

    @RequestMapping(value = "/addArticleType",method = RequestMethod.POST)
    @RequiresPermissions("business:articleType:add")
    public String addArticleType(ArticleType articleType){
        articleTypeService.save(articleType);
        return "business/articleType-list";
    }

    @RequestMapping(value = "/editArticleType",method = RequestMethod.POST)
    @RequiresPermissions("business:articleType:alter")
    public String editDept(ArticleType articleType){
        articleTypeService.updateById(articleType);
        return "/business/articleType-list";
    }

    @RequestMapping(value = "/removeArticleType",method = RequestMethod.POST)
    @RequiresPermissions("business:articleType:remove")
    @ResponseBody
    public R removeDept(Integer typeId){
        if (typeId==null){
            return R.error("请先勾选要删除的文章类别");
        }
        try {
            articleTypeService.removeById(typeId);
            return R.ok();
        } catch (Exception e) {
            return R.error("未知错误，请联系管理员");
        }
    }

    @RequestMapping(value = "/getTargetArticleTypes" )
    @ResponseBody
    public R getTargetArticleTypes(){
        List<ArticleType> articleTypeList=articleTypeService.list();
        return R.ok().put("articleTypeList",articleTypeList);
    }


}
