/*****
 * Author: Jennifer Cafiero
 * Date: May 2, 2017
 * I pledge my honor that I have abided by the Stevens Honor System
 * CS392 Lab 11
 */

#include <ncurses.h>

int main() {
    char str[80];
    initscr();
    scrollok(stdscr, TRUE);
    refresh();
    clear();
    echo();
    int row = 0;
    while(1) {
        echo();
        move(row, 0);
        getstr(str);
        start_color();
        init_pair(1, COLOR_RED, COLOR_BLACK);
        attron(COLOR_PAIR(1));
        printw("%s", str);
        attroff(COLOR_PAIR(1));
        
        noecho();
        int exit_cmd;
        
        exit_cmd = getch();
        if (exit_cmd == 23) {
            break;
        }

        row += 2;
    }

    endwin();
    return 0;
}