package com.dlt.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.common.model.R;
import com.dlt.common.model.TreeNode;
import com.dlt.sys.entity.Role;
import com.dlt.sys.entity.RoleResource;
import com.dlt.sys.service.IRoleResourceService;
import com.dlt.sys.service.IRoleService;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * <p>
 * 角色 前端控制器
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;


    @Autowired
    IRoleResourceService roleResourceService;

    /**
     * 跳转到列表
     *
     * @return
     */
    @GetMapping
    @RequiresPermissions("sys:role:list")
    public String list() {
        return "/sys/role-list";
    }

    /**
     * 获取列表数据
     */
    @GetMapping("/data")
    @RequiresPermissions("sys:role:list")
    @ResponseBody
    public R data(Integer roleId, String roleName, String startTime, String endTime, Page<Role> page) {
        //1.构造查询条件构造器
        QueryWrapper queryWrapper = new QueryWrapper();
        if (null!=roleId) {
            queryWrapper.like("role_id", roleId);
        }
        if (!StringUtils.isEmpty(roleName)) {
            queryWrapper.like("role_name", roleName);
        }
        if ((!StringUtils.isEmpty(startTime))&&(!StringUtils.isEmpty(endTime))) {
            //queryWrapper.like("create_time", startTime);
            queryWrapper.between("create_time", startTime,endTime);
        }
        //2.分页查询
        roleService.page(page, queryWrapper);
        //3.返回分页数据
        return R.ok(page);
    }




    @RequestMapping(value = "/showAllRoles")
    @RequiresPermissions("sys:role:list")
    public ModelAndView showAllRoles(ModelAndView modelAndView){
        List<Role> roleList=roleService.list();
        modelAndView.addObject("roleList",roleList);
        modelAndView.setViewName("/sys/role-list");
        return modelAndView;
    }





    @RequestMapping(value = "/addRole",method = RequestMethod.POST)
    @RequiresPermissions("sys:role:add")
    public String addRole(Role role){
        roleService.save(role);
        return "redirect:/role/showAllRoles";
    }


    @RequestMapping(value = "/editRole",method = RequestMethod.POST)
    @RequiresPermissions("sys:role:update")
    public String editRole(Role role){
        roleService.updateById(role);
        return "redirect:/role/showAllRoles";
    }

    @RequestMapping(value = "/removeRole",method = RequestMethod.POST)
    @RequiresPermissions("sys:role:delete")
    @ResponseBody
    public R removeRole(Integer roleId){
        if (roleId==null){
            return R.error("请先勾选要移除的角色");
        }
        try {
            roleService.removeById(roleId);
            return R.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("出现未知错误，请联系管理员");
        }

    }

    /**
     * 获取选中资源菜单的数据
     *
     * @param roleId
     * @return
     */
    @PostMapping("/assign/resourceTree")
    @RequiresPermissions("sys:role:assign:resource")
    @ResponseBody
    public R assignResourceTree(Integer roleId) {
        TreeNode treeNode = roleResourceService.getTreeByRoleId(roleId);

        return R.ok("请求成功", treeNode).put("roleId",roleId);
    }


    /**
     * 保存给角色分配的资源
     * @param roleId
     * @param roleResourceList
     * @return
     */
    @PostMapping("/assign/resource/{roleId}")
    @RequiresPermissions("sys:role:assign:resource")
    @ResponseBody
    public R assignResource(@PathVariable Integer roleId, @RequestBody List<RoleResource> roleResourceList) {
        System.out.println(roleResourceList);
        roleResourceService.save(roleId, roleResourceList);
        return R.ok();
    }
}
