package org.csu.wutheringwaves.dto;

public record UserReadResult(
        Long id,
        String username,
        String displayName,
        String role,
        String status
) {
}