package com.smarthospital.exception;

/**
 * Custom application-level exception for business logic and validation failures.
 */
public class ApplicationException extends RuntimeException {
    private static final long serialVersionUID = 1L;

    public ApplicationException(String message) {
        super(message);
    }

    public ApplicationException(String message, Throwable cause) {
        super(message, cause);
    }
}
