package com.company.utils;

public enum InputPatterns {
    email {
        @Override
        public String getPattern() {
            return "^\\w+([\\.-]?\\w+)*@\\w+([\\.-]?\\w+)*(\\.\\w{2,3})+$";
        }
    },
    password {
        @Override
        public String getPattern() {
            return "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,12}$";
        }
    },
    distance {
        @Override
        public String getPattern() {
            return "^\\d{2,4}$";
        }
    },
    price_per_km {
        @Override
        public String getPattern() {
            return "^\\d{2,4}\\.\\d{1,2}$";
        }
    };

    public abstract String getPattern();
}
