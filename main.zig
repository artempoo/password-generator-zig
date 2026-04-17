const std = @import("std");

pub fn main() !void {
    const LENGTH_PASS: u8 = 12;
    const LEN_GROUP: u8 = LENGTH_PASS / 4;

    var password: [LENGTH_PASS]u8 = undefined;

    const uppercase: []const u8 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const lowercase: []const u8 = "abcdefghijklmnopqrstuvwxyz";
    const numbers: []const u8 = "0123456789";
    const special: []const u8 = "!@#$*_";

    const rand = std.crypto.random;

    for (0..LEN_GROUP) |index| {
        password[index] = uppercase[rand.intRangeLessThan(usize, 0, uppercase.len)];
    }
    for (LEN_GROUP..(LEN_GROUP * 2)) |index| {
        password[index] = lowercase[rand.intRangeLessThan(usize, 0, lowercase.len)];
    }
    for ((LEN_GROUP * 2)..(LEN_GROUP * 3)) |index| {
        password[index] = numbers[rand.intRangeLessThan(usize, 0, numbers.len)];
    }
    for ((LEN_GROUP * 3)..(LEN_GROUP * 4)) |index| {
        password[index] = special[rand.intRangeLessThan(usize, 0, special.len)];
    }

    var i = LENGTH_PASS - 1;

    while (i > 0) : (i -= 1) {
        const random_index: u8 = rand.intRangeAtMost(u8, 0, i);
        const current_char = password[i];
        const random_char = password[random_index];
        password[random_index] = current_char;
        password[i] = random_char;
    }

    std.debug.print("{s}\n", .{password});
}
