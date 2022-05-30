package com.company.model;

public class User {

    private String login;
    private String password;
    private String email;
    private Role role;

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public static Builder newBuilder() {
        return new User().new Builder();
    }

    public class Builder {
        private Builder() {
        }

        public Builder setLogin(String firstName) {
            User.this.login = firstName;
            return this;
        }

        public Builder setPassword(String password) {
            User.this.password = password;
            return this;
        }

        public Builder setEmail(String email) {
            User.this.email = email;
            return this;
        }

        public Builder setRole(Role role) {
            User.this.role = role;
            return this;
        }


        public User build() {
            return User.this;
        }
    }
}
