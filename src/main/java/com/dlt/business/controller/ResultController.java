package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.Joy;
import com.dlt.business.entity.Result;
import com.dlt.business.service.IJoyService;
import com.dlt.business.service.IResultService;
import com.dlt.common.model.R;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
@Controller
@RequestMapping("/business/result")
public class ResultController {

    @Autowired
    private IResultService resultService;

    @GetMapping
    @RequiresPermissions("business:result:search")
    public String resultManagement(){
        return "/business/resultManagement";
    }

    @RequestMapping(value = "/findAllResult")
    @RequiresPermissions("business:result:search")
    @ResponseBody
    public R findAllResult(Page<Result> page, Result result){
        QueryWrapper<Result> queryWrapper=new QueryWrapper<Result>();
        if (!StringUtils.isEmpty(result.getExamType())){
            queryWrapper.like("exam_type",result.getExamType());
        }
        if (null != result.getuId()){
            queryWrapper.like("u_id",result.getuId());
        }

        resultService.page(page, queryWrapper);
        return R.ok(page);
    }


    @RequestMapping(value = "/addResult",method = RequestMethod.POST)
    @RequiresPermissions("business:result:add")
    @ResponseBody
    public R addResult(Result result){
        resultService.save(result);
        return R.ok();
    }

    @RequestMapping(value = "/editResult",method = RequestMethod.POST)
    @RequiresPermissions("business:result:edit")
    @ResponseBody
    public R editResult(Result result){
        resultService.updateById(result);
        return R.ok();
    }

    @RequestMapping(value = "deleteTargetResult")
    @RequiresPermissions("business:result:remove")
    @ResponseBody
    public R deleteTargetResult(Integer resultId){
        resultService.removeById(resultId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "batchDeleteResult")
    @RequiresPermissions("business:result:batchRemove")
    @ResponseBody
    public R batchDeleteResult(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        resultService.removeByIds(list);
        return R.ok("删除成功");
    }

}
