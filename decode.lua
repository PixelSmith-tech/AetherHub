return function(safe_gsub, safe_uchar)
    local function BuildDecoder(lut, pattern)
        local local_lut = {}
        for k, v in pairs(lut) do local_lut[k] = v end

        local function check()
            local ok1 = (safe_gsub("aa", "a", "b") == "bb")
            local ok2 = (type(local_lut) == "table")
            if not (ok1 and ok2) then error("Decoder integrity check failed", 0) end
        end

        check()

        return function(encoded)
            local decoded = safe_gsub(encoded, pattern, local_lut)
            if type(decoded) ~= "string" then
                error("Decoder returned non-string", 0)
            end
            return decoded
        end
    end

    return BuildDecoder
end
