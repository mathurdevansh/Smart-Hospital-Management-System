package com.smarthospital.util;

import java.util.regex.Pattern;

/**
 * Centralized utility for input validation and sanitization.
 */
public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
    );

    private static final Pattern PHONE_PATTERN = Pattern.compile(
            "^[0-9+\\-\\s()]{7,20}$"
    );

    private ValidationUtil() {
        // Utility class
    }

    public static boolean isNotEmpty(String str) {
        return str != null && !str.trim().isEmpty();
    }

    public static boolean isValidEmail(String email) {
        if (!isNotEmpty(email)) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPhone(String phone) {
        if (!isNotEmpty(phone)) {
            return false;
        }
        return PHONE_PATTERN.matcher(phone.trim()).matches();
    }

    public static boolean isValidPassword(String password) {
        // Minimum 6 characters
        return password != null && password.trim().length() >= 6;
    }

    public static boolean isPositiveNumber(String value) {
        if (!isNotEmpty(value)) {
            return false;
        }
        try {
            double d = Double.parseDouble(value.trim());
            return d > 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isNonNegativeNumber(String value) {
        if (!isNotEmpty(value)) {
            return false;
        }
        try {
            double d = Double.parseDouble(value.trim());
            return d >= 0;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    public static boolean isInteger(String value) {
        if (!isNotEmpty(value)) {
            return false;
        }
        try {
            Integer.parseInt(value.trim());
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    /**
     * Basic XSS defense by escaping HTML special characters.
     */
    public static String sanitize(String input) {
        if (input == null) {
            return null;
        }
        return input.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;")
                    .trim();
    }
}
