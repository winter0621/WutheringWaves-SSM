package org.csu.wutheringwaves.service;

import com.baomidou.mybatisplus.core.MybatisConfiguration;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.TableInfoHelper;
import org.apache.ibatis.builder.MapperBuilderAssistant;
import org.csu.wutheringwaves.dto.UserReadResult;
import org.csu.wutheringwaves.entity.User;
import org.csu.wutheringwaves.mapper.UserMapper;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.dao.DataAccessResourceFailureException;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertSame;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

class UserServiceTest {

    @BeforeAll
    static void initializeUserTableInfo() {
        MapperBuilderAssistant assistant =
                new MapperBuilderAssistant(new MybatisConfiguration(), "UserServiceTest");

        assistant.setCurrentNamespace(UserMapper.class.getName());
        TableInfoHelper.initTableInfo(assistant, User.class);
    }

    @Test
    void findByUsername_shouldConvertUserToReadResult_whenUserExists() {
        UserMapper userMapper = mock(UserMapper.class);
        UserService userService = new UserService(userMapper);

        User user = new User();
        user.setId(1L);
        user.setUsername("hzx");
        user.setDisplayName("海啸");
        user.setRole("CUSTOMER");
        user.setStatus("ENABLED");
        user.setPasswordHash("should-not-be-returned");

        when(userMapper.selectOne(any(LambdaQueryWrapper.class))).thenReturn(user);

        Optional<UserReadResult> result = userService.findByUsername("hzx");

        assertTrue(result.isPresent());
        assertEquals(
                new UserReadResult(1L, "hzx", "海啸", "CUSTOMER", "ENABLED"),
                result.orElseThrow()
        );
        verify(userMapper).selectOne(any(LambdaQueryWrapper.class));
    }

    @Test
    void findByUsername_shouldReturnEmptyOptional_whenUserDoesNotExist() {
        UserMapper userMapper = mock(UserMapper.class);
        UserService userService = new UserService(userMapper);

        when(userMapper.selectOne(any(LambdaQueryWrapper.class))).thenReturn(null);

        Optional<UserReadResult> result = userService.findByUsername("not-exists");

        assertTrue(result.isEmpty());
        verify(userMapper).selectOne(any(LambdaQueryWrapper.class));
    }

    @Test
    void findByUsername_shouldRethrowSameException_whenMapperFails() {
        UserMapper userMapper = mock(UserMapper.class);
        UserService userService = new UserService(userMapper);

        DataAccessResourceFailureException expected =
                new DataAccessResourceFailureException("database unavailable");

        when(userMapper.selectOne(any(LambdaQueryWrapper.class))).thenThrow(expected);

        DataAccessResourceFailureException actual = assertThrows(
                DataAccessResourceFailureException.class,
                () -> userService.findByUsername("hzx")
        );

        assertSame(expected, actual);
    }
}