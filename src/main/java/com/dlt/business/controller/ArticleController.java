package com.dlt.business.controller;


import com.dlt.business.entity.Activity;
import com.dlt.business.entity.Article;
import com.dlt.business.service.IArticleService;
import com.dlt.common.model.R;
import net.sf.json.JSONArray;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
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
@RequestMapping("/business/article")
public class ArticleController {

    @Autowired
    private IArticleService articleService;

    @GetMapping
    @RequiresPermissions("business:article:search")
    public String articleManagement() {
        return "/business/article-list";
    }

    @RequestMapping(value = "/findTargetArticle")
    @RequiresPermissions("business:article:search")
    @ResponseBody
    public R findTargetArticle(){
        List<Article> articleList=articleService.list();
        return R.ok().put("rows",articleList);
    }

    @RequestMapping(value = "/addArticle",method = RequestMethod.POST)
    @RequiresPermissions("business:article:add")
    @ResponseBody
    public R addArticle(Article article){
        articleService.save(article);
        return R.ok();
    }

    @RequestMapping(value = "/editArticle",method = RequestMethod.POST)
    @RequiresPermissions("business:article:edit")
    @ResponseBody
    public R editarticle(Article article){
        articleService.updateById(article);
        return R.ok();
    }

    @RequestMapping(value = "/removeTargetArticle",method = RequestMethod.POST)
    @RequiresPermissions("business:article:remove")
    @ResponseBody
    public R removeTargetArticle(Integer articleId){
        if (articleId==null){
            return R.error("请勾选要删除的文章！");
        }
        try {
            articleService.removeById(articleId);
            return R.ok();
        } catch (Exception e) {
            return R.error("该文章下存在权限或者其他信息，不能删除！");
        }
    }

    @RequestMapping(value = "/batchDeleteArticle")
    @RequiresPermissions("business:article:batchRemove")
    @ResponseBody
    public R batchDeleteArticle(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        articleService.removeByIds(list);
        return R.ok("删除成功");
    }

    @RequestMapping(value = "/getTargetArticle" )
    @ResponseBody
    public R getTargetArticle(){
        List<Article> articleList=articleService.list();
        return R.ok().put("articleList",articleList);
    }

    @RequestMapping(value = "/findByTargetArticle",method = RequestMethod.POST)
    @ResponseBody
    public R findByTargetArticle(Integer articleId){
        Article article=articleService.getById(articleId);
        return R.ok().put("article",article);
    }


}
