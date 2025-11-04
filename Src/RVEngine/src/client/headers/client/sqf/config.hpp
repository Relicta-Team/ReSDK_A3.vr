#pragma once
/*!
@file
@author Verox (verox.averre@gmail.com)
@author Nou (korewananda@gmail.com)
@author Glowbal (thomasskooi@live.nl)

@brief Functions used to access and parse RV Engine configuration files.

These are functions that are used to access the config class structure in the RV
Engine.

https://github.com/NouberNou/intercept
*/
#include "shared/client_types.hpp"

using namespace intercept::types;

namespace intercept {
    namespace sqf {
        class config_entry {
        public:


            class iterator {
                const config_entry* p_;
                size_t index{0};

            public:
                using iterator_category = std::random_access_iterator_tag;
                using value_type = config_entry;
                using difference_type = ptrdiff_t;
                using pointer = config_entry *;
                using reference = config_entry &;

                /**
 * @brief Constructs an empty iterator.
 *
 * Initializes the iterator to an invalid/empty state (does not refer to any config_entry).
 */
iterator() : p_(nullptr) {}
                /**
 * @brief Constructs an iterator that references the given config_entry at index zero.
 *
 * @param p The config_entry to iterate over; the iterator holds a pointer to this entry.
 */
explicit iterator(const config_entry &p) noexcept : p_(&p) {}
                /**
 * @brief Constructs an iterator referring to a specific element of a config_entry by index.
 *
 * @param p The config_entry to iterate over (iterator will reference this object).
 * @param index_ Zero-based index of the element within `p` that the iterator will point to.
 */
explicit iterator(const config_entry &p, size_t index_) noexcept : p_(&p), index(index_) {}
                /**
 * @brief Constructs a new iterator by copying another iterator.
 *
 * @param other The iterator to copy.
 */
iterator(const iterator &other) noexcept : p_(other.p_) {}
                /**
                 * @brief Make this iterator refer to the same config_entry as another iterator.
                 *
                 * Assigns the underlying config_entry pointer from `other` while preserving this iterator's current index.
                 *
                 * @param other Iterator to copy the referenced config_entry from.
                 * @return iterator& Reference to this iterator.
                 */
                iterator &operator=(const iterator &other) {
                    p_ = other.p_;
                    return *this;
                }
                /**
                 * @brief Advance the iterator to the next element.
                 *
                 * @return iterator& Reference to this iterator after increment.
                 */
                iterator &operator++() noexcept {
                    ++index;
                    return *this;
                }  /**
                 * @brief Advance the iterator by one position and yield the iterator's previous value.
                 *
                 * Performs a postfix increment: the iterator is advanced, and a copy representing
                 * the iterator state prior to the increment is returned.
                 *
                 * @return iterator A copy of the iterator as it was before the increment.
                 */
                iterator operator++(int) {
                    iterator tmp(*this);
                    ++(*this);
                    return tmp;
                }  /**
                 * @brief Move the iterator to the previous element.
                 *
                 * Decrements the iterator's position by one and returns a reference to the updated iterator.
                 *
                 * @return iterator& Reference to the iterator after decrement.
                 */
                iterator &operator--() noexcept {
                    --index;
                    return *this;
                }  /**
                 * @brief Postfix decrement operator that moves the iterator one position toward the beginning and yields the original iterator.
                 *
                 * @return iterator The iterator value prior to the decrement.
                 */
                iterator operator--(int) {
                    iterator tmp(*this);
                    --(*this);
                    return tmp;
                }  /**
 * @brief Advance the iterator forward by a given number of positions.
 *
 * @param n Number of positions to advance the iterator's index.
 */

                void operator+=(const std::size_t &n) { index += n; }
                /**
 * @brief Adds another iterator's offset to this iterator.
 *
 * Increases this iterator's position by the position value of @p other.
 *
 * @param other Iterator whose position will be added to this iterator.
 */
void operator+=(const iterator &other) { index += other.index; }
                /**
                 * @brief Returns an iterator advanced by the given number of positions.
                 *
                 * @param n Number of positions to advance the iterator.
                 * @return iterator A new iterator pointing `n` positions past the original.
                 */
                iterator operator+(const std::size_t &n) const {
                    iterator tmp(*this);
                    tmp += n;
                    return tmp;
                }
                /**
                 * @brief Produce a new iterator advanced by the position of another iterator.
                 *
                 * @param other Iterator whose index will be added to this iterator's index.
                 * @return iterator A new iterator representing this iterator moved forward by `other`'s index.
                 */
                iterator operator+(const iterator &other) const {
                    iterator tmp(*this);
                    tmp += other;
                    return tmp;
                }

                /**
 * @brief Move the iterator backward by a given number of positions.
 *
 * @param n Number of positions to subtract from the iterator's current index.
 */
void operator-=(const std::size_t &n) noexcept { index -= n; }
                /**
 * @brief Move the iterator's position backward by another iterator's index.
 *
 * @param other Iterator whose index will be subtracted from this iterator's index.
 */
void operator-=(const iterator &other) noexcept { index -= other.index; }
                /**
                 * Produces a new iterator moved backward by the specified number of positions.
                 *
                 * @param n Number of positions to move the iterator backward.
                 * @return iterator Positioned `n` elements before this iterator.
                 */
                iterator operator-(const std::size_t &n) const {
                    iterator tmp(*this);
                    tmp -= n;
                    return tmp;
                }
                /**
 * @brief Compute the distance in elements between this iterator and another.
 *
 * @return std::size_t Number of elements from `other` to `this` (this->index minus other.index).
 */
std::size_t operator-(const iterator &other) const noexcept { return index - other.index; }

                /**
 * @brief Compare two iterators by their position to determine strict ordering.
 *
 * @param other Iterator to compare against.
 * @return `true` if this iterator's position is less than `other`'s position, `false` otherwise.
 */
bool operator<(const iterator &other) const noexcept { return (index - other.index) < 0; }
                /**
 * @brief Determine whether this iterator precedes or is equal to another iterator.
 *
 * Compares iterators by their underlying index values.
 *
 * @param other The iterator to compare against.
 * @return `true` if this iterator's index is less than or equal to `other`'s index, `false` otherwise.
 */
bool operator<=(const iterator &other) const noexcept { return (index - other.index) <= 0; }
                /**
 * @brief Determine whether this iterator is positioned after another iterator.
 *
 * @param other Iterator to compare against.
 * @return `true` if this iterator's index is greater than the other's index, `false` otherwise.
 */
bool operator>(const iterator &other) const noexcept { return (index - other.index) > 0; }
                /**
 * @brief Determine whether this iterator is greater than or equal to another.
 *
 * @param other Iterator to compare against.
 * @return true if this iterator's index is greater than or equal to the other's index, false otherwise.
 */
bool operator>=(const iterator &other) const noexcept { return (index - other.index) >= 0; }
                /**
 * @brief Check whether two iterators refer to the same position.
 *
 * @param other Iterator to compare against.
 * @return `true` if both iterators refer to the same position, `false` otherwise.
 */
bool operator==(const iterator &other) const noexcept { return index == other.index; }
                /**
 * @brief Checks whether this iterator and another refer to different positions.
 *
 * @param other Iterator to compare with.
 * @return `true` if the iterators refer to different positions, `false` otherwise.
 */
bool operator!=(const iterator &other) const noexcept { return index != other.index; }

                /**
 * @brief Accesses the config_entry at the iterator's current position.
 *
 * @return const config_entry& Reference to the current entry. Behavior is undefined if the iterator is not dereferenceable (for example, past-the-end or constructed with a null target).
 */
const config_entry &operator*() const noexcept { return p_[index]; }
                /**
 * @brief Accesses the current element referenced by the iterator.
 *
 * @return const config_entry* Pointer to the `config_entry` at the iterator's current position.
 */
const config_entry *operator->() const noexcept { return &(p_[index]); }
            };

            config_entry();
            config_entry(types::config entry_);
            config_entry(config_entry const &copy_);
            config_entry(config_entry &&move_) noexcept;
            /**
 * @brief Copy-assigns state from another config_entry.
 *
 * @param copy_ The config_entry to copy from.
 * @return config_entry& Reference to this config_entry after assignment.
 */
config_entry &operator=(const config_entry &copy_) = default;
            config_entry &operator=(config_entry &&move_) noexcept;
            bool operator==(const config_entry &other_) const;
            config_entry operator>>(sqf_string_const_ref entry_) const;
            /**
 * @brief Accesses a child configuration entry by key.
 *
 * @param entry_ Key or name of the sub-entry to retrieve.
 * @return config_entry The config_entry corresponding to the named sub-entry.
 */
config_entry operator[](sqf_string_const_ref entry_) const { return *this >> entry_; }
            config_entry operator[](size_t index_) const;
            size_t count() const;
            iterator begin() const;
            iterator end() const;


            operator config &() const;
        protected:
            mutable types::config _config_entry;
            mutable bool _initialized;
        };

        std::vector<config> config_hierarchy(const config &config_entry_);
        sqf_return_string config_name(const config &config_entry_);
        std::vector<config> config_properties(const config &config_entry, sqf_string_const_ref condition_ = "true", bool inherit = true);
        sqf_return_string config_source_mod(const config &config_entry_);
        sqf_return_string_list config_source_mod_list(const config &config_entry_);
        int count(const config &config_entry_);
        //std::vector<game_value> get_array(const config &config_entry_);
        config get_mission_config(sqf_string_const_ref value_);
        float get_number(const config &config_entry_);
        sqf_return_string get_text(const config &config_entry_);
        config inherits_from(const config &config_entry_);
        bool is_array(const config &config_entry_);
        bool is_class(const config &config_entry_);
        bool is_null(const config &config_entry_);
        bool is_number(const config &config_entry_);
        bool is_text(const config &config_entry_);
        std::vector<config> config_classes(sqf_string_const_ref condition_, const config &config_);
        config select(const config &a_config_, int a_number_);
        config campaign_config_file();
        config config_file();
        config config_null();
        config mission_config_file();
        config config_of(const object &obj_);
        game_value get_array(const config &config_);

        game_value get_mission_config_value(sqf_string_const_ref attribute_);
        game_value get_mission_config_value(sqf_string_const_ref attribute_, game_value default_value_);

        //config
        bool is_kind_of(const object &obj_, sqf_string_const_ref type_);
        bool is_kind_of(sqf_string_const_ref type1_, sqf_string_const_ref type2_);
        bool is_kind_of(sqf_string_const_ref type1_, sqf_string_const_ref type2_, const config &target_config_);

        sqf_return_string_list config_source_addon_list(const config &config_);
        enum class mod_params_options : uint32_t {
            name = 1,          //String - name to be shown(Arma 3 instead of A3, etc.)
            picture = 2,       //String - picture shown in Mod Launcher
            logo = 4,          //String - logo to be shown in Main Menu
            logoOver = 8,      //String - logo to be shown in Main Menu when mouse is over
            logoSmall = 0x10,     //String - small version of logo, prepared for drawing small icons
            tooltip = 0x20,       //String - tooltip to be shown on mouse over
            tooltipOwned = 0x40,  //String - tooltip to be shown on mouse over the icon when DLC is owned by player
            action = 0x80,        //String - url to be triggered when mod button is clicked
            actionName = 0x100,    //String - what to put on Action Button
            overview = 0x200,      //String - overview text visible in expansion menu
            hidePicture = 0x400,   //Boolean - do not show mod picture icon in the main menu mod list
            hideName = 0x800,      //Boolean - do not show mod name in the main menu mod list
            defaultMod = 0x1000,    //Boolean - default mods cannot be moved or disabled by Mod Launcher
            serverOnly = 0x2000,    //Boolean - mod doesn't have to be installed on client in order to play on server with this mod running
            active = 0x4000        //Boolean - active mod(activated through command line or stored in profile by mod launcher)
        };

        /**
         * @brief Combine two mod parameter option flags using bitwise OR.
         *
         * @param _Left Left-hand set of mod_params_options flags.
         * @param _Right Right-hand set of mod_params_options flags.
         * @return mod_params_options Combined flags with bits set from both operands.
         */
        inline constexpr mod_params_options operator|(mod_params_options _Left, mod_params_options _Right) {
            return (static_cast<mod_params_options>(static_cast<unsigned int>(_Left)
                                                    | static_cast<unsigned int>(_Right)));
        }
        /**
         * @brief Tests whether two mod_params_options flag sets share any common flags.
         *
         * @param _Left Left operand flags.
         * @param _Right Right operand flags.
         * @return true if any flag is set in both operands, false otherwise.
         */
        inline constexpr bool operator&(mod_params_options _Left, mod_params_options _Right) {
            return (static_cast<unsigned int>(_Left)
                    & static_cast<unsigned int>(_Right));
        }
        std::vector<game_value> mod_params(sqf_string_const_ref mod_class_, mod_params_options options_);
        sqf_return_string type_of(const object &value_);
        sqf_return_string get_text_raw(const config &config_);

        config load_config(sqf_string_const_ref file_path_);
    }  // namespace sqf
}  // namespace intercept