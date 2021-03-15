package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.Exam;
import com.dlt.business.entity.Joy;
import com.dlt.business.service.IExamService;
import com.dlt.business.service.IJoyService;
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
 * @since 2021-03-02
 */
@Controller
@RequestMapping("/business/exam")
public class ExamController {

    @Autowired
    private IExamService examService;

    @GetMapping
    @RequiresPermissions("business:exam:search")
    public String examManagement(){
        return "/business/examManagement";
    }

    @RequestMapping(value = "/findAllExam")
    @RequiresPermissions("business:exam:search")
    @ResponseBody
    public R findAllExam(Page<Exam> page, Exam exam){
        QueryWrapper<Exam> queryWrapper=new QueryWrapper<Exam>();
        if (!StringUtils.isEmpty(exam.getTitle())){
            queryWrapper.like("title",exam.getTitle());
        }
        if (!StringUtils.isEmpty(exam.getType())){
            queryWrapper.like("type",exam.getType());
        }
        examService.page(page, queryWrapper);
        return R.ok(page);
    }


    @RequestMapping(value = "/addExam",method = RequestMethod.POST)
    @RequiresPermissions("business:exam:add")
    @ResponseBody
    public R addExam(Exam exam){
        examService.save(exam);
        return R.ok();
    }

    @RequestMapping(value = "/editExam",method = RequestMethod.POST)
    @RequiresPermissions("business:exam:edit")
    @ResponseBody
    public R editExam(Exam exam){
        examService.updateById(exam);
        return R.ok();
    }

    @RequestMapping(value = "deleteTargetExam")
    @RequiresPermissions("business:exam:remove")
    @ResponseBody
    public R deleteTargetExam(Integer businessId){
        examService.removeById(businessId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "batchDeleteExam")
    @RequiresPermissions("business:exam:batchRemove")
    @ResponseBody
    public R batchDeleteExam(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        examService.removeByIds(list);
        return R.ok("删除成功");
    }

}
