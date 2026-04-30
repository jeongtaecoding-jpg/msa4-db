-- VIEW 생성
CREATE VIEW view_avg_salary_by_dept
AS
	-- 부서별 현재 연봉 평균 구하기
	-- 부서명(한글), 평균연봉 출력
--  GROUP BY에 없는 컬럼은 SELECT에 쓰지 말라 (집계 함수 제외)
	SELECT dept.dept_name, CEILING(AVG(sal.salary)) avg_sal
	FROM salaries sal
		JOIN department_emps deps
			ON sal.emp_id = deps.emp_id 
				AND sal.end_at IS NULL 
				AND deps.end_at IS NULL 
		JOIN departments dept 
			ON dept.dept_code = deps.dept_code
				AND dept.end_at IS NULL 
	GROUP BY dept.dept_name
	ORDER BY avg_sal DESC
;
	

-- 뷰 조회하기
SELECT 
	*
FROM view_avg_salary_by_dept
WHERE 
	avg_sal >= 44000000
;	
	

-- VIEW 삭제
DROP VIEW view_avg_salary_by_dept;

