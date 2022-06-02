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
    },
    date {
        @Override
        public String getPattern() {
            return "^[0-9]{4}-(0[1-9]|1[0-2])-(3[01]|[12][0-9]|0[1-9])$";
        }
    },
    city {
        @Override
        public String getPattern() {
            return "([A-Z][a-z]{3,30}|[(А-Я|І|Ї)][(а-я|і|ї)]{2,29})";
        }
    },
    cargo {
        @Override
        public String getPattern() {
            return "^\\d{1,2}(|\\.[0-9])$";
        }
    };

    public abstract String getPattern();
}
