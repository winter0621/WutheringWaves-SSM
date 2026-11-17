package org.csu.wutheringwaves.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.csu.wutheringwaves.entity.User;

@Mapper
public interface UserMapper extends BaseMapper<User> {
}