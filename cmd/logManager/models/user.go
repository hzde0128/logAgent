package models

// User 用户表
type User struct {
	ID       int
	Username string `orm:"unique"` // 用户名
	Password string // 用户密码
}
