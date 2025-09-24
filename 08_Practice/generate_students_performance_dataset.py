import random
import uuid
import mysql.connector
from faker import Faker

def generate_student_record(fake: Faker) -> tuple:
    """Generate a single student record with UUID id."""
    student_id = str(uuid.uuid4())  # generate UUID string
    name = fake.name()
    age = random.randint(15, 22)
    gender = random.choice(["Male", "Female"])
    math_score = random.randint(0, 100)
    reading_score = random.randint(0, 100)
    writing_score = random.randint(0, 100)
    return (student_id, name, age, gender, math_score, reading_score, writing_score)

def insert_students(
    host: str,
    user: str,
    password: str,
    database: str,
    total_rows: int = 1_000_000,
    batch_size: int = 10_000
) -> None:
    """
    Generate and insert synthetic student performance data into MySQL.

    Args:
        host (str): MySQL host
        user (str): MySQL user
        password (str): MySQL password
        database (str): Database name
        total_rows (int): Number of rows to insert
        batch_size (int): Rows per batch insert
    """
    connection = mysql.connector.connect(
        host='127.0.0.1',
        user='root',
        password='Aa123456',
        database='p08'
    )
    cursor = connection.cursor()

    fake = Faker()

    insert_query = """
        INSERT INTO students_performance
        (id, name, age, gender, math_score, reading_score, writing_score)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """

    for i in range(0, total_rows, batch_size):
        batch = [generate_student_record(fake) for _ in range(batch_size)]
        cursor.executemany(insert_query, batch)
        connection.commit()
        print(f"Inserted {min(i + batch_size, total_rows)} / {total_rows} rows")

    cursor.close()
    connection.close()
    print("✅ Data insertion complete!")

if __name__ == "__main__":
    insert_students(
        host="localhost",
        user="root",
        password="your_password",
        database="your_database",
        total_rows=10_000_000,  # Change here if needed
        batch_size=100_000
    )
