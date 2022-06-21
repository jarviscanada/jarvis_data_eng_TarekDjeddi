--  Group hosts by CPU number and sort by their memory size in descending order
SELECT
    info.cpu_number, usage.host_id, info.total_mem
FROM host_info AS info
JOIN host_usage AS usage
    ON info.id = usage.host_id
GROUP BY info.cpu_number, usage.host_id, info.total_mem
ORDER BY info.total_mem DESC;

-- Create round down function (5 mins)
CREATE FUNCTION round5(ts timestamp) RETURNS timestamp AS
$$
BEGIN
    RETURN date_trunc('hour', ts) + date_part('minute', ts):: int / 5 * interval '5 min';
END;
$$
    LANGUAGE PLPGSQL;

-- Average memory usage over 5 mins interval
SELECT
 usage.host_id,
 info.hostname AS host_name,
 round5(usage.timestamp) AS timestamp,
 AVG(((info.total_mem - usage.memory_free)*100)/info.total_mem)  AS avg_used_mem_percentage
FROM host_usage AS usage
JOIN host_info AS info
    ON usage.host_id = info.id
GROUP BY round5(usage.timestamp), usage.host_id, host_name
ORDER BY round5(usage.timestamp);

-- Count number of data points over each 5 mins interval
SELECT
 host_id,
 round5(timestamp) AS timest,
 COUNT(timestamp)
FROM host_usage
GROUP BY round5(timestamp), host_id
ORDER BY round5(timestamp);