const std = @import("std");

pub fn main() !void {
    const LENGTH_PASS: u8 = 12;
    const LEN_GROUP: u8 = LENGTH_PASS / 4;

    var password: [LENGTH_PASS]u8 = .{0} ** LENGTH_PASS;

    const uppercase: []const u8 = "ABCDEFJHIGKLMNOPQRSTUVWXYZ";
    const lowercase: []const u8 = "abcdefjhigklmnopqrstuvwxyz";
    const numbers: []const u8 = "0123456789";
    const special: []const u8 = "!@#$*_";

    const rand = std.crypto.random;

    for (0..LEN_GROUP) |index| {
        password[index] = uppercase[rand.intRangeAtMost(u8, 0, 25)];
    }
    for (LEN_GROUP..(LEN_GROUP * 2)) |index| {
        password[index] = lowercase[rand.intRangeAtMost(u8, 0, 25)];
    }
    for ((LEN_GROUP * 2)..(LEN_GROUP * 3)) |index| {
        password[index] = numbers[rand.intRangeAtMost(u8, 0, 9)];
    }
    for ((LEN_GROUP * 3)..(LEN_GROUP * 4)) |index| {
        password[index] = special[rand.intRangeAtMost(u8, 0, 5)];
    }

    std.debug.print("{s}\n", .{password});
}
