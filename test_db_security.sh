#!/bin/bash

# Test script for database security
echo "🔒 Testing MariaDB Security Configuration..."

# Test 1: Try to connect without password (should fail)
echo "Test 1: Connecting without password..."
if docker exec mariadb mysql -u root -e "SELECT 1;" 2>/dev/null; then
    echo "❌ FAIL: Root access without password is allowed!"
    exit 1
else
    echo "✅ PASS: Root access without password is denied"
fi

# Test 2: Try to connect with wrong password (should fail)
echo "Test 2: Connecting with wrong password..."
if docker exec mariadb mysql -u root -pwrongpassword -e "SELECT 1;" 2>/dev/null; then
    echo "❌ FAIL: Root access with wrong password is allowed!"
    exit 1
else
    echo "✅ PASS: Root access with wrong password is denied"
fi

# Test 3: Try to connect with correct password (should work)
echo "Test 3: Connecting with correct password..."
if docker exec mariadb mysql -u root -padmin_password_123 -e "SELECT 1;" 2>/dev/null; then
    echo "✅ PASS: Root access with correct password works"
else
    echo "❌ FAIL: Root access with correct password failed!"
    exit 1
fi

# Test 4: Try to connect as WordPress user (should work)
echo "Test 4: Connecting as WordPress user..."
if docker exec mariadb mysql -u wordpress_user -pwordpress_password_123 -e "SELECT 1;" 2>/dev/null; then
    echo "✅ PASS: WordPress user access works"
else
    echo "❌ FAIL: WordPress user access failed!"
    exit 1
fi

# Test 5: Try to access other databases as WordPress user (should fail)
echo "Test 5: WordPress user trying to access other databases..."
if docker exec mariadb mysql -u wordpress_user -pwordpress_password_123 -e "USE mysql; SELECT 1;" 2>/dev/null; then
    echo "❌ FAIL: WordPress user can access mysql database!"
    exit 1
else
    echo "✅ PASS: WordPress user cannot access other databases"
fi

echo "🎉 All security tests passed! Database is properly secured."
