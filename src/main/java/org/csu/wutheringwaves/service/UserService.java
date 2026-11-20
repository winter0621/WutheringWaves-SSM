package org.csu.wutheringwaves.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.csu.wutheringwaves.dto.UserReadResult;
import org.csu.wutheringwaves.entity.User;
import org.csu.wutheringwaves.mapper.UserMapper;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserService {

    private final UserMapper userMapper;

    public UserService(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public Optional<UserReadResult> findByUsername(String username) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<User>()
                .select(
                        User::getId,
                        User::getUsername,
                        User::getDisplayName,
                        User::getRole,
                        User::getStatus
                )
                .eq(User::getUsername, username);

        User user = userMapper.selectOne(queryWrapper);

        return Optional.ofNullable(user)
                .map(item -> new UserReadResult(
                        item.getId(),
                        item.getUsername(),
                        item.getDisplayName(),
                        item.getRole(),
                        item.getStatus()
                ));
    }
}