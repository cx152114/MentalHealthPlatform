package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.Exam;
import com.dlt.business.entity.Joy;
import com.dlt.business.entity.Result;
import com.dlt.business.service.IExamService;
import com.dlt.business.service.IJoyService;
import com.dlt.business.service.IResultService;
import com.dlt.common.model.R;
import com.dlt.sys.entity.User;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import javax.jnlp.IntegrationService;
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

    @Autowired
    private IResultService resultService;

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

    @RequestMapping(value = "/deleteTargetExam")
    @RequiresPermissions("business:exam:remove")
    @ResponseBody
    public R deleteTargetExam(Integer businessId){
        examService.removeById(businessId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "/batchDeleteExam")
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

    @RequestMapping(value = "/findTargetExam",method = RequestMethod.POST)
    @ResponseBody
    public R findTargetExam(Integer businessId){
        Exam exam=examService.getById(businessId);
        return R.ok().put("exam",exam);
    }


    @GetMapping(value = "/studentExam")
    @RequiresPermissions("business:exam:search")
    public String studentExam(){
        return "/business/student-exam";
    }

    //@RequestMapping(value = "/findTargetStudentExam/{type}")
    @RequestMapping(value = "/findTargetStudentExam")
    @RequiresPermissions("business:exam:search")
    @ResponseBody
    //public R findTargetStudentExam(@PathVariable String type){
    public R findTargetStudentExam(String type){
        QueryWrapper<Exam> queryWrapper = new QueryWrapper<>();
        if (! StringUtils.isEmpty(type)){
            queryWrapper.like("type",type);
        }
        queryWrapper.last("limit 0,10");
        List<Exam> exams=examService.list(queryWrapper);
        return R.ok().put("exams",exams);
    }

    @RequestMapping(value = "/generateExamResult")
    @RequiresPermissions("business:exam:search")
    public String generateExamResult(Integer question0,Integer question1,Integer question2,Integer question3,Integer question4,Integer question5,Integer question6,Integer question7,Integer question8,Integer question9,String examType){
        Integer sum = question0
                +question1
                +question2
                +question3
                +question4
                +question5
                +question6
                +question7
                +question8
                +question9;

        System.out.println(sum);
        Result result = new Result();
        User user = (User) SecurityUtils.getSubject().getPrincipal();
        result.setUId(user.getUserId());
        result.setScore((sum*100)/40);
        result.setExamType(examType);
        String resultLevel = "";
        String description ="";
        String suggest = "";
        if(result.getScore() !=null){
            if (result.getScore() > 90 && result.getScore() <= 100){
                resultLevel = "优秀";
                if (result.getExamType().equals("综合测试")) {
                    description = "你是一个阳光活泼,性格开朗的人," +
                            "心情就像花儿一样,给周围的人带来与众不同的惊喜与甜蜜";
                    suggest = "你是一个很阳光没有心理疾病的人,可以用自己的好心态去影响和帮助更多的人";
                } else if (result.getExamType().equals("日常交往")) {
                    description = "你是一个擅长交际，外向阳光的人，你不仅能够和别人相处融洽，还能够用自己乐观" +
                            "善良的性格感染他人，让他人在你的帮助下能够快乐积极起来!";
                    suggest = "你的日常交际能力比较强，建议多实用这方面的长处帮助别人";
                } else if (result.getExamType().equals("人格检测")) {
                    description = "你是一个阳光自信，总为别人着想的人，你周围的人都因为你优秀的品质而接触你，人格吸引力特别强！";
                    suggest = "建议多用自己的优秀品质感染帮助别人";
                } else if (result.getExamType().equals("情感测试")) {
                    description = "你是一个乐观，对爱情比较忠诚的人。在爱情里面，在乎对方，时刻为对方着想，因此爱情比较美满";
                    suggest = "已经很完美了，建议多保持";
                }
            }else if (result.getScore() > 80 && result.getScore() <= 90){
                resultLevel = "良好";
                if (result.getExamType().equals("综合测试")) {
                    description = "你是一个比较开朗阳光的人,但同时也害怕孤独和冷清";
                    suggest = "建议用自己乐观驱走偶尔的悲观,活得更加快乐";
                } else if (result.getExamType().equals("日常交往")) {
                    description = "你的日常交际能力较强，能够发挥团队的力量解决问题，" +
                            "但是有时候做事难免有点利用成分,因此久而久之会发生很多矛盾";
                    suggest = "日常交际能力较强,但是要注意交朋友的目的,注重他人的感受";
                } else if (result.getExamType().equals("人格检测")) {
                    description = "你的人格影响力比较强，能够让周围的人因为你而快乐";
                    suggest = "你的人格品质良好,建议在一些小细节上注意改变";
                } else if (result.getExamType().equals("情感测试")) {
                    description = "你的情感指数比较强，能够充分为对方考虑，但不可避免在一些细节方面美中不足";
                    suggest = "多注意细节会更好哦";
                }
            }else if (result.getScore() > 60 && result.getScore() <= 80){
                resultLevel="合格";
                if (result.getExamType().equals("综合测试")){
                    description = "你是一个比较压抑的人,总是将自己处于一个死胡同,让自己的心情就像" +
                            "变换莫测的天气阴晴不定,因此也给周围想关心你的人带来伤害与痛苦";
                    suggest = "你是一个比较抑郁的人,多出去走走,多散心，多和别人聊聊天,不要让自己孤独";
                }else if(result.getExamType().equals("日常交往")){
                    description="你的日常交际能力很弱，一方面可能是因为性格内向，另一方面是害怕接触他人，" +
                            "无法敞开心扉，向别人打开一扇通往自己心底的门";
                    suggest="勇敢一点，大胆敞开心扉，向别人展示独一无二的自我";
                }else if(result.getExamType().equals("人格检测")){
                    description="你是一个满足基本品质的人，但欠缺乐于助人，为他人着想的无私品质";
                    suggest="建议多为别人着想，互相理解更好";
                }else if(result.getExamType().equals("情感测试")){
                    description="你的情感指数较弱，对对方并不是很投入，导致爱情会出现很多波折";
                    suggest="建议及时调整心态,及时改变自己";
                }
            }else if ( result.getScore() < 60){
                resultLevel="不合格";
                if (result.getExamType().equals("综合测试")){
                    description = "你是一个严重抑郁压抑的人,整天愁眉苦脸,多愁善感,生活就像一座冰冷的" +
                            "雪山,你孤僻倔强而又专断独行,完全看不到生活的希望与动力," +
                            "敏感的神经使得周围的人都不敢接触你";
                    suggest = "你的心理疾病比较严重,建议多去医院检查,不然可能走向极端";
                }else if(result.getExamType().equals("日常交往")){
                    description="你的交际能力特别差，几乎没有什么交际能力，" +
                            "你孤僻冷漠，排斥他人，专断独行，独来独往，完全活在自己的世界里";
                    suggest="你的心理问题比较严重，嫉妒心又特别重，建议改变自己的心态，重新认识这个世界!";
                }else if(result.getExamType().equals("人格检测")){
                    description="你的品质不是很好，总只在乎自己，比较自私，因此周围的人都排斥你";
                    suggest="建议打开心扉，多理解别人的想法，及时改变自己的想法与态度";
                }else if(result.getExamType().equals("情感测试")){
                    description="你的情感指数极差,几乎没有遇到过爱情";
                    suggest="及时调整自己,不然后果不堪设想";
                }
            }
        }
        result.setResultLevel(resultLevel);
        result.setDescription(description);
        result.setSuggest(suggest);
        resultService.save(result);
        return "redirect:/login/index";
    }

}
