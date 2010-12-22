# InflectorLiterals
#
# This exists so I can say inflect.literal, pass it two strings, and control exactly
# what humanize returns for some strings. The default humanize calls capitalize on
# the result, which I don't want.

module InflectorLiterals
    def literal(str, replacement)
        literals.insert(0, [str, replacement])
    end

    def literals ; @literals ||= [] ; end
end

ActiveSupport::Inflector::Inflections.send :include, InflectorLiterals

# I hate having to do this but I couldn't find another way.
module ActiveSupport::Inflector
    alias humanize_without_literals humanize

    def humanize word
        inflections.literals.each { |(str, replacement)| return replacement if word == str }
        humanize_without_literals word
    end
end
