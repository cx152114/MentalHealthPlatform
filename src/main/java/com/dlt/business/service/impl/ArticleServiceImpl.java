package com.dlt.business.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.business.entity.Article;
import com.dlt.business.entity.ArticleType;
import com.dlt.business.mapper.ArticleMapper;
import com.dlt.business.mapper.ArticleTypeMapper;
import com.dlt.business.service.IArticleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dlt.business.service.IArticleTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cx
 * @since 2021-02-14
 */
@Service
public class ArticleServiceImpl extends ServiceImpl<ArticleMapper, Article> implements IArticleService {

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private ArticleTypeMapper articleTypeMapper;

    @Override
    public List<Article> list() {
        List<Article> articleList =new ArrayList<>();
        QueryWrapper <Article> queryWrapper = new QueryWrapper<>();
        articleList = articleMapper.selectList(queryWrapper);
        for (Article article:articleList) {
            ArticleType articleType = articleTypeMapper.selectById(article.getTypeId());
            article.setArticleType(articleType);
        }
        return articleList;
    }

    @Override
    public Article getById(Serializable id) {
        Article article = null;
            article =    articleMapper.selectById(id);
        ArticleType articleType = null;
            articleType =  articleTypeMapper.selectById(article.getTypeId());
        article.setArticleType(articleType);
        return article;
    }
}
